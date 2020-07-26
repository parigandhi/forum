A sample project that runs phpBB forum on Apache web server using mySQL as the database server. Also includes phpmyadmin to view the database tables.  <br/>

<h3>Some useful commands:</h3><br/>
  <code> git clone https://github.com/parigandhi/forum.git  </code><br/><br/>
  <code>docker-compose build --no-cache </code> <br/>
  <code>docker-compose up -d  </code><br/>
  <code>docker-compose down  </code><br/>
  <code>docker system prune -a </code><br/>

<h3>Deploying the code to Google Cloud Platform:</h3><br/>
 1. Create a GCP project.<br/>
 2. Open the Cloud Console.<br/>
 3. Clone the code
 <code> git clone https://github.com/parigandhi/forum.git  </code><br/>
 4. Go to the folder
  <code> cd forum</code><br/>
 5. Build an image
  Syntax: <code>gcloud builds submit --tag gcr.io/[project id]/[tag for the image]</code><br/>
	<code>gcloud builds submit --tag gcr.io/my-docker-php-mysql/docker-gcp-tag</code><br/>  
  GCP will ask you whether you want to enable the APIs. Select y to enable API<br/>
 6. Verify that your image was successfully stored in GCP <br/>
 Go to Storage > Storage > Browse <br/>
 You will see two files - appspot.com and cloudbuild <br/>
 appspot.com contains the container image and cloudbuild contains the source code as a tar file <br/>
 7. Run the docker image on Google Cloud <br/>
 Syntax: <code> gcloud run deploy --image gcr.io/[project id]/[tag for the image]</code><br/>
<code>gcloud run deploy --image gcr.io/my-docker-php-mysql/docker-gcp-tag></code><br/>
Google will  ask the target platform - Cloud Run (fully managed) - or - Cloud Run for Anthos deployed on Google Cloud-or- Cloud Run for Anthos deployed on VMWare<br/>
Select Cloud Run (fully managed) <br/>
Select enter to go with default service<br/>
Select y to enable API<br/>
Select a region to deploy the service<br/>
Select y to unauthenticated invocations<br/>
8. Once the service is published, Google Console will give you a URL to access the website. Click on it to launch your website.
