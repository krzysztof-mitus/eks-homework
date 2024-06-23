import unittest
from app import app

class AppTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_index_route(self):
        response = self.app.get('/index.html')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to homework index.html TEST page', response.data)

    def test_echo_route(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'environment name', response.data)
        self.assertIn(b'local ip', response.data)
        self.assertIn(b'geo-location', response.data)

if __name__ == '__main__':
    unittest.main()