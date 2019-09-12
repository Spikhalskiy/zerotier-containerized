# zerotier-containerized

It's a minimalistic docker image with Zerotier client.
The original version was taken from the Zerotier repo with applied patch https://github.com/Spikhalskiy/ZeroTierOne/blob/b61b3da59fe24bb96c1c0b09e28deac5814306a7/ext/installfiles/linux/zerotier-containerized/
and now maintained as a separate repo with Dockerfile based on Alpine Linux to keep it lightweight.

This docker is doing the same as the containerized client from upstream https://github.com/zerotier/ZeroTierOne/tree/master/ext/installfiles/linux/zerotier-containerized just based on a different docker base image.