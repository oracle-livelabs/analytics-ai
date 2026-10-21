/*
 * Copyright (c) 2026 Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at
 * https://oss.oracle.com/licenses/upl/.
 */
(function () {
  'use strict';

  var gateSelector = '[data-license-gate]';
  var cloneSelector = '[data-license-gated-clone]';
  var termsUrl = new URL('../appendix-1-license.html', document.currentScript.src).href;
  var accepted = false;
  var observer;

  function hideCloneCommands() {
    document.querySelectorAll(cloneSelector).forEach(function (clone) {
      clone.classList.add('license-gate-is-hidden');
      clone.setAttribute('aria-hidden', 'true');
    });
  }

  function revealCloneCommands() {
    accepted = true;
    document.querySelectorAll(cloneSelector).forEach(function (clone) {
      clone.classList.remove('license-gate-is-hidden');
      clone.setAttribute('aria-hidden', 'false');
    });
    document.querySelectorAll('[data-license-gate-status]').forEach(function (status) {
      status.textContent = 'License agreement accepted. The download commands are now available.';
    });
  }

  function closeDialog(dialog) {
    dialog.remove();
  }

  function openAgreement() {
    var overlay = document.createElement('div');
    overlay.className = 'license-gate-modal';
    overlay.innerHTML = [
      '<section class="license-gate-dialog" role="dialog" aria-modal="true" aria-labelledby="license-gate-title">',
      '<h2 id="license-gate-title">Oracle Technology Network License Agreement</h2>',
      '<p>Appendix 1 — License agreement for authorized code sample distributions.</p>',
      '<div class="license-gate-terms" data-license-gate-terms tabindex="0"><p>Loading license agreement…</p></div>',
      '<label class="license-gate-confirmation"><input type="checkbox" data-license-gate-confirm disabled> I confirm that I have reviewed and accept the License Agreement.</label>',
      '<button type="button" class="license-gate-button" data-license-gate-accept disabled>Accept License Agreement</button>',
      '<button type="button" class="license-gate-button license-gate-button--secondary" data-license-gate-decline>Decline License Agreement</button>',
      '</section>'
    ].join('');
    document.body.appendChild(overlay);

    var terms = overlay.querySelector('[data-license-gate-terms]');
    var confirmation = overlay.querySelector('[data-license-gate-confirm]');
    var acceptButton = overlay.querySelector('[data-license-gate-accept]');
    var reachedEnd = false;

    function updateAcceptState() {
      acceptButton.disabled = !(reachedEnd && confirmation.checked);
    }

    function markEndWhenRead() {
      if (terms.scrollTop + terms.clientHeight >= terms.scrollHeight - 4) {
        reachedEnd = true;
        confirmation.disabled = false;
        updateAcceptState();
      }
    }

    terms.addEventListener('scroll', markEndWhenRead);
    confirmation.addEventListener('change', updateAcceptState);
    acceptButton.addEventListener('click', function () {
      revealCloneCommands();
      closeDialog(overlay);
    });
    overlay.querySelector('[data-license-gate-decline]').addEventListener('click', function () {
      hideCloneCommands();
      document.querySelectorAll('[data-license-gate-status]').forEach(function (status) {
        status.textContent = 'You must accept the License Agreement to view the download commands.';
      });
      closeDialog(overlay);
    });

    fetch(termsUrl)
      .then(function (response) {
        if (!response.ok) throw new Error('Unable to load license agreement.');
        return response.text();
      })
      .then(function (html) {
        terms.innerHTML = html;
        terms.focus();
        markEndWhenRead();
      })
      .catch(function () {
        terms.innerHTML = '<p>The license agreement could not be loaded. Please reload the page and try again.</p>';
      });
  }

  function initializeGates() {
    document.querySelectorAll(gateSelector).forEach(function (gate) {
      if (gate.dataset.licenseGateInitialized === 'true') return;
      gate.dataset.licenseGateInitialized = 'true';
      // A newly rendered Lab 1 page requires a fresh acknowledgement.
      accepted = false;
      hideCloneCommands();
      gate.querySelector('[data-license-gate-review]').addEventListener('click', openAgreement);
      openAgreement();
    });
  }

  observer = new MutationObserver(initializeGates);
  observer.observe(document.documentElement, { childList: true, subtree: true });
  initializeGates();
}());
