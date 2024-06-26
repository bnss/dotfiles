import { createLocalVue, mount } from '@vue/test-utils';
import lodashDefaults from 'lodash/defaults';

const vuetify = new Vuetify();
const localVue = createLocalVue();

let wrapper;

describe('${NAME}', () => {
  it('renders the component correctly', () => {
    expect(mountWrapper().vm).toBeTruthy();
  });
});

function mountWrapper(data = {}) {
  return mount(${NAME}, {
    propsData: lodashDefaults(data, {}),
    vuetify,
    i18n,
    localVue,
  });
}