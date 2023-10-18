// Importation des bibliothèques nécessaires
import express from 'express';

// Création de l'application Express
const app = express();

// Définition des routes
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// Démarrage du serveur
app.listen(3000, () => {
    console.log('Serveur en écoute sur le port 3000');
});
