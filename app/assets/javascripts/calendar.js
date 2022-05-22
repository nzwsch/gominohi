const calendar = document.getElementById("calendar");
const wrapper = calendar.querySelector(".wrapper");

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

for (let i = 0; i < 7; i++) {
  const div = document.createElement("div");
  div.classList.add("week");
  div.innerHTML = WEEKDAYS[i];
  wrapper.appendChild(div);
}

for (let i = 1; i <= 7 * 5; i++) {
  const div = document.createElement("div");
  div.classList.add("date", "text-muted");
  if (i > beggingOfTheMonth && i <= endOfTheMonth) {
    div.innerHTML = (i - beggingOfTheMonth).toString();
  }
  wrapper.appendChild(div);
}
