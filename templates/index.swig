{% extends "layout.swig" %}

{% block body %}
<div class="jumbotron">
	<h1><img src="img/logo.png" /></h1>
	<p class="lead">Partage de fichiers.</p>
	{% include "upload_form.swig" %}
</div>
{% include "banners.swig" %}
{% include "nav.swig" %}
{% endblock %}
