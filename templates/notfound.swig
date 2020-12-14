{% extends "layout.swig" %}

{% block title %}Element not found - Error 404{% endblock %}
{% block body %}
<article class="page--notfound">
	<div class="jumbotron">
		<img src="img/notfound.svg" alt="Content was not found">
		<h1 class="medium">Ressource not found.</h1>
		<p><strong>The link you've provided may have expired, and the ressource has been deleted.</strong></p>
		<p>Get back to the <a href="/" title="Homepage">Homepage</a>.</p>
	</div>
</article>
{% include "nav.swig" %}
{% endblock %}