# WitsNote/serializers.py
from rest_framework import serializers                      # type: ignore
from .models import Post, PostImage, ListicleSubheading


class PostImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostImage
        fields = ['id', 'image', 'caption']


class ListicleSubheadingSerializer(serializers.ModelSerializer):
    class Meta:
        model = ListicleSubheading
        fields = ['id', 'title', 'content']


class PostSerializer(serializers.ModelSerializer):
    images = PostImageSerializer(many=True, required=False)
    listicles = ListicleSubheadingSerializer(many=True, required=False)

    class Meta:
        model = Post
        fields = ['id', 'title', 'content', 'author', 'images', 'listicles']
        read_only_fields = ['author']

    def create(self, validated_data):
        images_data = validated_data.pop('images', [])
        listicles_data = validated_data.pop('listicles', [])
        post = Post.objects.create(**validated_data)

        for image_data in images_data:
            PostImage.objects.create(post=post, **image_data)

        for listicle_data in listicles_data:
            ListicleSubheading.objects.create(post=post, **listicle_data)

        return post
