<div class="row">
    <div class="col-sm-8 blog-main">
        <div class="blog-post">
            {% if is_post() %}
            <h2 class="panel-heading">{{ post.title }}</h2>
            {% else %}
            <h2><a href="{{ url_for(post.path) }}" class="panel-heading">{{ post.title }}</a></h2>
            {% endif %}

            {{ post.content }}
        </div>
    </div>
</div>