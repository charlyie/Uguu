{% extends "layout.swig" %}

{% block title %}Tools{% endblock %}
{% block body %}
<div class="jumbotron">
<h1>Uguu Tools</h1>
</div>
    <h3>
      To upload using curl or make a tool you can post using:

      <br/>

      curl -i -F files[]=@yourfile.jpeg {{siteUrl}}/upload.php (JSON Response)
    </h3>
<section>
	<h2>ShareX</h2>
	<dl>
		<dt>Download Uguu Client (Bash)</dt>
		<dd><a href="https://github.com/charlyie/uguu-client" target="_blank">https://github.com/charlyie/uguu-client</a></dd>
	</dl>
</section>
{% include "nav.swig" %}
{% endblock %}
