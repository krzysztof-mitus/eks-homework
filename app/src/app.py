from flask import Flask, render_template, request
import socket
import os
import geocoder

app = Flask(__name__, static_folder=os.getenv('TEMPLATES_DIR', 'templates'))


@app.route('/index.html', methods=['GET'])
def index():
    try:
        output = render_template('index.html')
    except Exception as e:
        output = f"Error occured while rendering index.html: {str(e)}"
    return output


@app.route('/', methods=['GET'])
def geolocation():
    remote_addr = request.remote_addr
    try:
        response = geocoder.ip(remote_addr)
        geolocation = f"{response.latlng}, CITY: {response.city}, COUNTRY: {response.country}"
    except Exception as e:
        geolocation = f"Error occurred while fetching geolocation: {str(e)}"

    try:
        output = render_template('geolocation.html',
                    cluster_env = os.getenv('CLUSTER_ENV', 'DEFAULT'),
                    local_address = socket.gethostbyname(socket.gethostname()),
                    remote_address = remote_addr,
                    geo_location = geolocation)
    except Exception as e:
        output = f"Error occured while rendering index.html: {str(e)}"

    return output


if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 8080, debug = True)