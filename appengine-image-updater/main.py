import os
import sys
import logging
from ConfigParser import SafeConfigParser
import webapp2

from google.appengine.ext import vendor
vendor.add('lib')

from googleapiclient import discovery
from oauth2client.client import GoogleCredentials


class Main(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write('Updater index')


class Updater(webapp2.RequestHandler):
    def __init__(self, request, response):
        super(Updater, self).__init__(request, response)
        self._parse_config()

    def _parse_config(self):
        config_path = os.path.dirname(os.path.realpath(__file__))+'/config.ini'

        parser = SafeConfigParser()

        if not os.path.exists(config_path):
            logging.info(config_path)
            logging.info('WTF?')
        try:
            parser.read(config_path)
        except Exception as e:
            logging.error(e)

        self.project = parser.get('project', 'project_id')
        self.region = parser.get('project', 'region')
        self.instance_group_manager = parser.get('project', 'instance_group_manager')

    def get(self):
        try:
            credentials = GoogleCredentials.get_application_default()
        except Exception as e:
            logging.error(e)

        try:
            service = discovery.build('compute', 'beta', credentials=credentials)
        except Exception as e:
            logging.error(e)

        instance_group_manager_body = {
            "updatePolicy": {
                "minimalAction": "REPLACE",
                "maxSurge": {
                    "fixed": 3
                },
                "maxUnavailable": {
                    "fixed": 0
                },
                "minReadySec": 0,
                "type": "PROACTIVE"
            },
            "versions": [
                {
                    "instanceTemplate": "projects/maciej-lasyk-info/global/instanceTemplates/ml-instance-template",
                    "name": "v1"
                }
            ]
        }

        request = service.regionInstanceGroupManagers().patch(
            project=self.project, region=self.region,
            instanceGroupManager=self.instance_group_manager,
            body=instance_group_manager_body
        )
        response = request.execute()

        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(response)
        logging.info(response)


app = webapp2.WSGIApplication([
    ('/', Main),
    ('/update', Updater)
], debug=False)
