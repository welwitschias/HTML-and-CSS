'use strict';

const img1 = document.querySelector('.img1');
const img2 = document.querySelector('.img2');

// img1, img2 class에 주사위 6이 나오도록 한다.
// img1.setAttribute('src', 'images/dice6.png');
// img2.setAttribute('src', 'images/dice6.png');

// 최댓값을 포함하는 정수 난수 생성하기
function getRandomIntInclusive(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min; // 최댓값도 포함, 최솟값도 포함
}
let randomNumber1 = getRandomIntInclusive(1, 6);
let randomNumber2 = getRandomIntInclusive(1, 6);

// let randomNumber1 = Math.floor(Math.random() * 6) + 1;
// let randomNumber2 = Math.floor(Math.random() * 6) + 1;

// random하게 주사위 image 출력하기
img1.setAttribute('src', 'images/dice' + randomNumber1 + '.png');
img2.setAttribute('src', 'images/dice' + randomNumber2 + '.png');

// 결과창 출력하기
const h1 = document.querySelector('h1');
function diceGameResult() {
    if (randomNumber1 > randomNumber2) { h1.textContent = '🚩 Player 1 Win'; }
    // 윈도우키 + ';' : 이모지 나옴
    else if (randomNumber1 < randomNumber2) { h1.textContent = 'Player 2 Win 🚩'; }
    else { h1.textContent = 'Draw!'; }
}   // 복잡해지면 함수로 지정해주는 게 좋음, 현재 예제에는 필요 없음.
diceGameResult();