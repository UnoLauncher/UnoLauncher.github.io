<div id=content-wrap">
    <div class="wrapper">
        {% for post in page.posts %}
        {{ partial('partial/post', {post: post}) }}
        {% endfor %}
    </div>
</div>
