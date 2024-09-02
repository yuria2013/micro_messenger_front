'use strict'

let loginUser;
const userPath = 'https://micro-messenger-user-micro-messenger.apps.cluster-01.hello-openshift.co.jp';
const messagePath = 'https://micro-messenger-message-micro-messenger.apps.cluster-01.hello-openshift.co.jp';

fetch("intersection/header.html")
            .then((response) => response.text())
            .then((data) => {
                document.querySelector("#header").innerHTML = data;

                // ヘッダーがロードされた後に実行するコード
                initializePage();
            });

// ページ初期化関数
function initializePage() {
    // ページ読み込み時にlocalStorageからユーザー情報を取得して表示
    loginUser = JSON.parse(localStorage.getItem('user'));

    if (loginUser) {
        const userIdDisplay = document.getElementById('user-id-display');
        const usernameDisplay = document.getElementById('username-display');
        const userInfo = document.getElementById('user-info');

        if (userIdDisplay && usernameDisplay && userInfo) {
            userIdDisplay.textContent = loginUser.id;
            usernameDisplay.textContent = loginUser.username;
        }
    }
}

