// Initialisation de l'application
document.addEventListener('DOMContentLoaded', () => {
    const app = document.getElementById('app');
    app.innerHTML = `
        <h1>Bienvenue sur MediaChain</h1>
        <div class="post">
            <p>Ceci est un exemple de post.</p>
            <button class="button" onclick="likePost()">Like</button>
        </div>
    `;
});

// Fonction pour "liker" un post
function likePost() {
    alert('Vous avez aimé ce post!');
}
