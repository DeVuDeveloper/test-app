import { screen } from '@testing-library/dom';
import { getHTML, setHTML, startStimulus } from './_stimulus_helper';
import CookieButtonsController from '../../app/javascript/controllers/cookie_buttons_controller';

beforeEach(() => startStimulus('cookie-buttons', CookieButtonsController));

test('selects a filling and updates UI', async () => {
  await setHTML(`
    <div data-controller="cookie-buttons">
      <button class="filling-button" data-filling="chocolate">Chocolate</button>
      <button class="filling-button" data-filling="strawberry">Strawberry</button>
      <button class="filling-button" data-filling="vanilla">Vanilla</button>
      <input type="hidden" data-cookie-buttons-target="selectedFilling" value="">
    </div>
  `);

  await screen.findByText('Chocolate');
  const chocolateButton = screen.getByText('Chocolate');
  const strawberryButton = screen.getByText('Strawberry');

  expect(getHTML()).toMatchSnapshot();

  chocolateButton.click();
  await screen.findByRole('button', { name: 'Chocolate' });

  expect(getHTML()).toMatchSnapshot();

  strawberryButton.click();
  await screen.findByRole('button', { name: 'Strawberry' });

  expect(getHTML()).toMatchSnapshot(); 
});
