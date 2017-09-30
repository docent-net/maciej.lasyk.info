import webapp2
import logging
from google.appengine.ext import vendor

vendor.add('lib')
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials


class Main(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write('Updater index')


class Updater(webapp2.RequestHandler):
    def get(self):
        credentials = GoogleCredentials.get_application_default()
        service = discovery.build('compute', 'beta', credentials=credentials)

        project = 'maciej-lasyk-info'
        region = 'us-central1'
        instance_group_manager = 'ml-instance-group-manager'

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
                    "instanceTemplate": "projects/maciej-lasyk-info/global/instanceTemplates/ml-instance-template"
                }
            ]
        }

        request = service.regionInstanceGroupManagers().patch(
            project=project, region=region,
            instanceGroupManager=instance_group_manager,
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
