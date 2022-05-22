const calendar = document.getElementById("calendar");
const wrapper = document.createElement("div");

const WEEKDAYS = ["日", "月", "火", "水", "木", "金", "土"];
const END_DAYS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

const getZeller = (y, m, d = 1) => {
  m = m < 3 ? m + 10 : m - 2;
  y = m > 10 ? y - 1 : y;
  return (parseInt((13 * m - 1) / 5, 10) + d + (y % 100) + parseInt((y % 100) / 4, 10) - 2 * parseInt(y / 100, 10) + parseInt(y / 400, 10) + 77) % 7;
};

const thisYear = parseInt(calendar.dataset.year, 10);
const thisMonth = parseInt(calendar.dataset.month, 10);
const beggingOfTheMonth = getZeller(thisYear, thisMonth);
const endOfTheMonth = END_DAYS[thisMonth - 1];
const todayYear = new Date().getFullYear(); // local
const todayMonth = new Date().getMonth() + 1; // local
const today = new Date().getDate();

for (let i = 0; i < 7; i++) {
  const div = document.createElement("div");
  div.classList.add("week");
  div.innerHTML = WEEKDAYS[i];
  wrapper.appendChild(div);
}

for (let i = 1; i <= 7 * 6; i++) {
  if (beggingOfTheMonth + endOfTheMonth <= 35 && i > 35) {
    break;
  }

  const div = document.createElement("div");
  div.classList.add("blank", "text-muted");

  if (i > beggingOfTheMonth && i - beggingOfTheMonth <= endOfTheMonth) {
    div.innerHTML = (i - beggingOfTheMonth).toString();
    div.classList.add("date");
  }

  if (thisYear === todayYear && thisMonth === todayMonth && i === today) {
    div.classList.add("today");
  }

  wrapper.appendChild(div);
}

wrapper.classList.add("wrapper");

calendar.appendChild(wrapper);
