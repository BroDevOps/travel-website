#!/bin/bash
cd /home/ubuntu/travel-website
sudo git pull origin main
docker-compose up -d --build
