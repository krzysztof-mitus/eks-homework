from flask import Flask, render_template, request
import socket
import os
import geocoder

app = Flask(__name__, static_folder=os.getenv('TEMPLATES_DIR', 'templates'))


@app.route('/index.html', methods=['GET'])
def index():
    return render_template('index.html')


@app.route('/', methods=['GET'])
def geolocation():
    remote_addr = request.remote_addr
    response = geocoder.ip(remote_addr)
    geolocation = f"{response.latlng}, CITY: {response.city}, COUNTRY: {response.country}"
    return render_template('geolocation.html',
                            env_name = os.getenv('ENV_NAME', 'DEFAULT_ENV'),
                            local_address = socket.gethostbyname(socket.gethostname()),
                            remote_address = remote_addr,
                            geo_location = geolocation)

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 8080, debug = True)