const calendar = document.getElementById('calendar')
const wrapper = calendar.querySelector('.wrapper')

const WEEKDAYS=['日', '月', '火', '水', '木', '金', '土']

for (let i = 0; i < 7; i++) {
  const div = document.createElement('div')
  div.classList.add("week")
  div.innerHTML = WEEKDAYS[i]
  wrapper.appendChild(div)
}

for (let i = 0; i < 7*5; i++) {
  const div = document.createElement('div')
  div.classList.add("date")
  wrapper.appendChild(div)
}
