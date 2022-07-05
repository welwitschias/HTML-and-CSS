'use strict';

const btns = document.querySelectorAll('.drum');

// =========================================================================

// 모든 버튼 클릭 - 반복문 사용

// function btnClickedAlert() {
//     alert('클릭!');
//     this.style.color = 'white';
// }

// for (let i = 0; i < btns.length; i++) {
//     btns[i].addEventListener('click', btnClickedAlert);
// };

// =========================================================================

// 클릭했을 때 소리 나오게 하기
// this : 현재 선택된(클릭한) 객체

function btnClickedAudio() {
    drumSound(this.textContent);    // 리팩토링 : 중복 제거
};

for (let i = 0; i < btns.length; i++) {
    btns[i].addEventListener('click', btnClickedAudio);
};

// =========================================================================

// 키보드 눌렀을 때 소리 나오게 하기
// 이벤트 객체 : 자동 생성
document.addEventListener('keydown', function (event) {
    drumSound(event.key);   // 리팩토링 : 중복 제거
});

// =========================================================================

function drumSound(key) {
    switch (key) {
        case "a":
            var audio = new Audio('sounds/tom-1.mp3');
            audio.play();
            break;
        case "s":
            var audio = new Audio('sounds/tom-2.mp3');
            audio.play();
            break;
        case "d":
            var audio = new Audio('sounds/tom-3.mp3');
            audio.play();
            break;
        case "f":
            var audio = new Audio('sounds/tom-4.mp3');
            audio.play();
            break;
        case "j":
            var audio = new Audio('sounds/snare.mp3');
            audio.play();
            break;
        case "k":
            var audio = new Audio('sounds/crash.mp3');
            audio.play();
            break;
        case "l":
            var audio = new Audio('sounds/kick-bass.mp3');
            audio.play();
            break;
    };
};