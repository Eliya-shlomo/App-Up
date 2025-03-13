import requests
import socket

NGINX_URL = "http://localhost:80"

def test_nginx_running():
    """Check if Nginx is listening on port 80"""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(("localhost", 80))
    sock.close()
    assert result == 0, "Nginx is not running on port 80"

def test_index_page():
    """Check if the index page loads correctly"""
    response = requests.get(NGINX_URL)
    assert response.status_code == 200, "Failed to load index page"
    assert "Welcome to My Custom Nginx Site!" in response.text, "Index page content is incorrect"
