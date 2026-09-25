# IT2140 — Lab Submissions (Labs 01–08)

**Asan M A M** · IT22253262 · Database Design and Development, Y2S1

Each file is named as its lab sheet requires, and holds only the section that
sheet asks to be submitted. The other exercises are in [`Practice/`](Practice/).

| Lab | File | Sheet asks for |
|---|---|---|
| 01 | `Lab_1_Exercises_Section_5.sql` | Section 5 |
| 02 | `Lab_2_Exercises_2.sql` | Exercises 2 |
| 03 | `Lab_3_CreateDB.sql` | Create table script |
| 04 | `Lab_4_CRUD.sql`, `Lab_4_JavaFX_Project/`, `Screenshots/` | App, project files, screenshots |
| 05 | `Lab_5_Exercises_2.sql` | Exercises 2 |
| 06 | `Lab_6_Exercises_2.sql` | Exercises 2 |
| 07 | `Lab 7 Exercises 2.sql` | Exercises 2 |
| 08 | `Lab_8_Exercises_1_2.sql` | Ex 1-c,d,e and Ex 2-c,d,e |

Lab 07's filename uses spaces rather than underscores because that is how the
sheet prints it.

## Running

Load the matching dataset first — `Datasets/Data_Set.sql` for labs 1, 2 and 8,
`Datasets/MovieData_Set.sql` for labs 5, 6 and 7. Lab 3 builds its own tables
and lab 4 runs on top of them.

`Datasets/Reset_For_Practice.sql` drops what labs 3, 4, 6 and 7 create, so
those can be run again from scratch.

## Notes

All eight scripts and all six practice scripts were run against SQL Server
2025 Express and pass. The JavaFX app compiles under JDK 21 with JavaFX
21.0.5 and its insert, update and delete were run against the live database —
`Screenshots/` holds the confirmations.

Three queries correctly return no rows, and say so in a comment:

| Query | Why |
|---|---|
| Lab 5 Ex 2-c, 2-e | `Booking` has two rows, both on showId 1 |
| Lab 8 Ex 2-c | Admin holds the company's joint highest earners, on 95,000 |
