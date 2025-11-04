function initBookCategorySearch() {
  const form = document.getElementById('bc-search-form');
  const input = document.getElementById('bc-search-input');
  if (!form || !input) return;

  // Guard so we don't attach handlers multiple times
  if (form.dataset.bcSearchInit === '1') return;
  form.dataset.bcSearchInit = '1';

  let timeout;
  input.addEventListener('input', function() {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      form.requestSubmit ? form.requestSubmit() : form.submit();
    }, 1000);
  });

  input.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      input.value = '';
      form.requestSubmit ? form.requestSubmit() : form.submit();
    }
  });
}

// Run on full page load and on Turbo navigation
document.addEventListener('DOMContentLoaded', initBookCategorySearch);
document.addEventListener('turbo:load', initBookCategorySearch);