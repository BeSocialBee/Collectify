from flask import Flask,request, jsonify, make_response, Response
import mysql.connector
from flask_cors import CORS
from werkzeug.utils import secure_filename
import uuid
import boto3
import os



app = Flask(__name__)
CORS(app)

app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024
#ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# MySQL database configuration
db_config = {
    'host': 'database-3.ciqpxqolslw4.eu-north-1.rds.amazonaws.com',
    'user': 'master',
    'password': 'masterpassword',
    'database': 'beedatabase',
    'port': 3306,
}

app.config['S3_BUCKET'] = "collectifybucket3"
app.config['S3_KEY'] = "AKIA6NTYCBG4H4RCIFXS"
app.config['S3_SECRET'] = "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"
app.config['S3_LOCATION'] = 'http://{}.s3.amazonaws.com/'.format(app.config['S3_BUCKET'])

s3 = boto3.client('s3',
                    aws_access_key_id=app.config['S3_KEY'],
                    aws_secret_access_key= app.config['S3_SECRET']
                    )




# Create a MySQL connection
db_connection = mysql.connector.connect(**db_config)
cursor = db_connection.cursor()

 # Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS userprofiles(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    fileURL VARCHAR(200) NOT NULL
);
"""
cursor.execute(create_table_query)

# user variables
global email
email = ""
password = ""
username = ""







# -----------------------------------------------------------------------------------------------------
# When user login, check whether user has created username or not. 
@app.route('/flutter_checkUsername', methods=['POST'])
def check_username():
    email = request.form.get('email')
    cursor.execute("SELECT username FROM userprofiles WHERE email = %s", (email,))
    username = cursor.fetchone()

    if username is None or len(username) == 0:
        response_data = {'message': 'Does not have username.', 'hasUsername': "false"}
        response = make_response(jsonify(response_data), 200)
        return response
    
    else: 
        response_data = {'message': 'Does have username.', 'hasUsername': "true"}
        response = make_response(jsonify(response_data), 200)
        return response


# -----------------------------------------------------------------------------------------------------
# Send username, email, registration date and image to use in user profil page
@app.route('/userprofile', methods=['GET'])
def get_user_data():

    cursor.execute("SELECT fileURL FROM userprofiles WHERE email = %s", (email,))
    imageURL = cursor.fetchone()

    cursor.execute("SELECT username FROM userprofiles WHERE email = %s", (email,))
    username = cursor.fetchone()

    cursor.execute("SELECT date FROM userprofiles WHERE email = %s", (email,))
    date = cursor.fetchone()


    user_data = {
        'username': username,
        'email': email,
        'registration_date': date,
        'fileURL': imageURL,
    }
    return jsonify(user_data)

# -----------------------------------------------------------------------------------------------------
@app.route('/flutter_usernamePP', methods=['POST'])
def set_usernamePP():
    global email 
    try:
        # get username and image from frontend
        username = request.form['username']
        image_file = request.files.get('image')

        # Generate a unique filename to avoid overwriting existing files
        filename = secure_filename(image_file.filename)
        unique_filename = f"{str(uuid.uuid4())}_{filename}"
        # Save the file to a temporary location
        temp_filepath = os.path.join('temp', unique_filename)
        image_file.save(temp_filepath)
         # Upload the file to S3
        s3.upload_file(
            temp_filepath,
            app.config['S3_BUCKET'],
            unique_filename
        )
        # Construct the S3 image URL
        s3_image_url = f"http://{app.config['S3_BUCKET']}.s3.amazonaws.com/{unique_filename}"

        # check if username is taken or not
        select_query = 'SELECT username FROM userprofiles WHERE username = %s'
        cursor.execute(select_query, (username,))
        existing_usernames = cursor.fetchall()

        if len(existing_usernames) >= 1:
                response_data = {'message': 'Username is already taken.', 'status_code': 5}
                response = make_response(jsonify(response_data), 200)
                return response

        
        cursor.execute("INSERT INTO userprofiles (email, username, fileURL) VALUES (%s, %s, %s)", (email, username, s3_image_url,))
        db_connection.commit()

        # Remove the temporary file
        os.remove(temp_filepath)

        return jsonify({'message': 'Profile uploaded successfully'}), 200
        
        
    except Exception as e:
        print(e)
        return jsonify({'error': 'Error uploading profile'}), 500



# -----------------------------------------------------------------------------------------------------
@app.route('/flutter_auth', methods=['POST'])
def authenticate_user():
    try:
        global email
        # Get email and password from the POST request
        email = request.form.get('email')
        password = request.form.get('password')
        _isLoginForm = request.form.get('_isLoginForm')

        # check login 
        if _isLoginForm=="true":
            select_query = 'SELECT email, password FROM users WHERE email = %s and password = %s'
            cursor.execute(select_query, (email,password,))
            queries = cursor.fetchall()

            if len(queries) == 1:
                response_data = {'message': 'Login Successful.', 'status_code': 1}
                response = make_response(jsonify(response_data), 200)
                return response
            else: 
                response_data = {'message': 'Email or password is incorrect.', 'status_code': 2}
                response = make_response(jsonify(response_data), 200)
                return response

        # signup 
        elif _isLoginForm=="false":
            # check whether email is in already database or not
            select_query = 'SELECT email, password FROM users WHERE email = %s'
            cursor.execute(select_query, (email,))
            queries = cursor.fetchall()

            if len(queries) >= 1:
                response_data = {'message': 'You already have an account.', 'status_code': 3}
                response = make_response(jsonify(response_data), 200)
                return response
            else:
                insert_query = 'INSERT INTO users (email, password) VALUES (%s, %s)'
                data = (email, password)
                cursor.execute(insert_query, data)
                db_connection.commit()

                response_data = {'message': 'Sign up is completed.', 'status_code': 4}
                response = make_response(jsonify(response_data), 200)
                return response
            
        return jsonify({'error': 'An error occurred'}), 500
       
    except Exception as e:
        # Handle exceptions and return an error response
        print(f'Error: {e}')
        return jsonify({'error': 'An error occurred'}), 500
    


if __name__ == "__main__":
    app.run()

