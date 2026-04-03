(function() {
  var html = document.documentElement;
  var saved = localStorage.getItem('rt-lumen-theme');
  var prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
  
  function initTheme() {
    if (saved === 'dark' || (saved === null && prefersDark)) {
      html.setAttribute('data-theme', 'dark');
      html.setAttribute('data-bs-theme', 'dark');
    } else {
      html.setAttribute('data-theme', 'light');
      html.setAttribute('data-bs-theme', 'light');
    }
  }

  initTheme();

  window.toggleLumenTheme = function() {
    var current = html.getAttribute('data-theme');
    var next = current === 'dark' ? 'light' : 'dark';
    html.setAttribute('data-theme', next);
    html.setAttribute('data-bs-theme', next);
    localStorage.setItem('rt-lumen-theme', next);
  };

  document.addEventListener('DOMContentLoaded', function() {
    var toggleBtn = document.getElementById('theme-toggle');
    if (toggleBtn) {
      toggleBtn.addEventListener('click', window.toggleLumenTheme);
    }

    document.querySelectorAll('.menu-toggle').forEach(function(btn) {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        var li = this.closest('li');
        li.classList.toggle('open');
      });
    });
  });

  if (window.matchMedia) {
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function(e) {
      if (!localStorage.getItem('rt-lumen-theme')) {
        html.setAttribute('data-theme', e.matches ? 'dark' : 'light');
        html.setAttribute('data-bs-theme', e.matches ? 'dark' : 'light');
      }
    });
  }
})();
