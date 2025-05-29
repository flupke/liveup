# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

alias Liveup.Repo
alias Liveup.Locations.Scene
alias Liveup.Schedule.Event

defmodule U do
  def t(day, hour, minute \\ 0) do
    month = if day >= 30, do: 5, else: 6
    NaiveDateTime.new!(2025, month, day, hour, minute, 0)
  end
end

canis_lupus = Repo.insert!(%Scene{name: "Canis Lupus", priority: 2})
la_clairiere = Repo.insert!(%Scene{name: "La Clairière", priority: 1})

# -- vendredi 30 - la clairiere --

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Jehan",
  start: U.t(30, 19),
  end: U.t(30, 20, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Phaz-M Dub",
  start: U.t(30, 20, 30),
  end: U.t(30, 22),
  type: "Band"
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "CosmoPat",
  type: "Live",
  start: U.t(30, 22),
  end: U.t(31, 0)
})

# -- vendredi 30 - canis lupus --

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Jozepe",
  start: U.t(30, 23),
  end: U.t(31, 0, 30)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Enzo",
  start: U.t(31, 0, 30),
  end: U.t(31, 2)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Probe1",
  start: U.t(31, 2),
  end: U.t(31, 3, 30)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "T.S.I",
  start: U.t(31, 3, 30),
  end: U.t(31, 5)
})

# -- samedi 31 - la clairiere --

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Haqay Pacha",
  type: "Gongbath",
  start: U.t(31, 10),
  end: U.t(31, 11)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Monicoli",
  start: U.t(31, 11),
  end: U.t(31, 12)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "1P-DLP",
  start: U.t(31, 12),
  end: U.t(31, 13, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Izuran",
  type: "Live",
  start: U.t(31, 13, 30),
  end: U.t(31, 15, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Johann Adam",
  start: U.t(31, 14, 30),
  end: U.t(31, 16)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Le Son du Desert",
  start: U.t(31, 16),
  end: U.t(31, 17, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Eclosion",
  type: "Duo Clown",
  start: U.t(31, 19),
  end: U.t(31, 20)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Leya Touch",
  start: U.t(31, 20),
  end: U.t(31, 21),
  type: "Live"
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "141-M3T",
  start: U.t(31, 21),
  end: U.t(31, 22),
  type: "Live"
})

# -- samedi 31 - canis lupus --

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Son du Maquis",
  start: U.t(31, 17),
  end: U.t(31, 19),
  type: "Live"
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Hangora",
  start: U.t(31, 22),
  end: U.t(1, 0),
  type: "Live"
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Animals in Cage",
  start: U.t(1, 0),
  end: U.t(1, 2)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Mik Izif",
  start: U.t(1, 2),
  end: U.t(1, 4)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Djonni Laser",
  start: U.t(1, 4),
  end: U.t(1, 6)
})

Repo.insert!(%Event{
  scene: canis_lupus,
  name: "Revol",
  start: U.t(1, 6),
  end: U.t(1, 8)
})

# -- dimanche 1er - la clairiere --

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "BDL1",
  start: U.t(1, 8),
  end: U.t(1, 9, 30),
  type: "Live"
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "1DRedFaces",
  start: U.t(1, 9, 30),
  end: U.t(1, 11, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Zulluz",
  start: U.t(1, 11, 30),
  end: U.t(1, 13),
  type: "Live"
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Geïnst",
  start: U.t(1, 13),
  end: U.t(1, 14, 30),
  type: "Live"
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Mistikri",
  start: U.t(1, 14, 30),
  end: U.t(1, 16, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "Beatum",
  start: U.t(1, 16, 30),
  end: U.t(1, 19, 30)
})

Repo.insert!(%Event{
  scene: la_clairiere,
  name: "¡Animate!",
  start: U.t(1, 19),
  end: U.t(1, 20)
})
