const express = require('express');
const app = express();
const PORT = 3000;

// Middleware pour servir des fichiers statiques depuis le dossier 'public'
app.use(express.static('public'));

// Route pour la page d'accueil
app.get('/', (req, res) => {
    res.send('Bienvenue sur la page d\'accueil!');
});

// Route pour la page de profil
app.get('/profile', (req, res) => {
    res.send('Voici la page de profil.');
});

// Gestion des erreurs 404 - Page non trouvée
app.use((req, res) => {
    res.status(404).send('Page non trouvée!');
});

// Lancement du serveur
app.listen(PORT, () => {
    console.log(`Serveur en écoute sur le port ${PORT}`);
});
