# deploy.sh

flutter build web
cd balls-252804.firebaseapp.com
rm -rdf public
mv ../build/web public
firebase deploy --only hosting
rm -rdf public
