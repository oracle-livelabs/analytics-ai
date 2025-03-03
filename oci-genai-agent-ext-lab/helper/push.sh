d=$(date +%Y-%m-%d_%H-%M) 
echo "$d"
git add .
git commit -m "$d"
git push origin main
