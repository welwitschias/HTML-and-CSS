'use strict';

const boxes = document.querySelectorAll('.box');
// 윈도우창에서 scroll하면 checkBoxes 함수 실행
window.addEventListener('scroll', checkBoxes);
// 처음 시작시 실행
checkBoxes();

function checkBoxes() {
    // 박스를 보여주거나 사라지게 하는 트리거포인트 (4/5는 임의로 지정한 값)
    const triggerBottom = (window.innerHeight / 5) * 4;

    boxes.forEach((box) => {
        const boxTop = box.getBoundingClientRect().top; //모든 박스의 상단 높이

        if (boxTop < triggerBottom) {
            box.classList.add('show'); // 박스 보이기(박스에 show class 달기)
        } else {
            box.classList.remove('show'); // 박스 안보이기(박스에 show class 삭제)
        }
    });
}
