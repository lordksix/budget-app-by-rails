document.addEventListener('DOMContentLoaded', function() {
    // open
  const burger = document.querySelectorAll('.navbar-burger');
  const menu = document.querySelectorAll('.navbar-menu');
  console.log(burger);
  console.log(menu);
  if (burger.length && menu.length) {
    burger.forEach((elem) => {
      elem.addEventListener('click', function() {
        menu.forEach((menuElem) => menuElem.classList.toggle('hidden'));
      });
    });
  }

  // close
  const close = document.querySelectorAll('.navbar-close');
  const backdrop = document.querySelectorAll('.navbar-backdrop');
  console.log(close);
  console.log(backdrop);
  if (close.length && menu.length) {
    close.forEach((elem) => {
      elem.addEventListener('click', function() {
        menu.forEach((menuElem) => menuElem.classList.toggle('hidden'));
      });
    });
  }

  if (backdrop.length && menu.length) {
    backdrop.forEach((elem) => {
      elem.addEventListener('click', function() {
        menu.forEach((menuElem) => menuElem.classList.toggle('hidden'));
      });
    });
  }
});

