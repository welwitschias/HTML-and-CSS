'use strict';

const h3 = document.querySelector('h3');
const color1 = document.querySelector('.color1');
const color2 = document.querySelector('.color2');
const body = document.querySelector('#gradient');

// =========================================================================

// 이벤트 함수 : addEventListerer(a,b) a는 이벤트 종류, b는 실행할 함수

// 익명함수 사용 : 일회용(함수 이름도 없음)
// color1.addEventListener('input', function () {
//     body.style.background = `linear-gradient(to right, ${color1.value}, ${color2.value})`;
//     h3.textContent = body.style.background + ";"
// });
// color2.addEventListener('input', function () {
//     body.style.background = `linear-gradient(to right, ${color1.value}, ${color2.value})`;
//     h3.textContent = body.style.background + ";"
// });

// 함수 정의해서 사용
function setGradient() {
    body.style.background = `linear-gradient(to right, ${color1.value}, ${color2.value})`;
    h3.textContent = body.style.background + ";"
}
color1.addEventListener('input', setGradient);
color2.addEventListener('input', setGradient);

// =========================================================================

