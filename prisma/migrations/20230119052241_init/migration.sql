-- CreateTable
CREATE TABLE "agents" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,

    CONSTRAINT "agents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "players" (
    "agent_id" INTEGER NOT NULL,
    "club_initials" TEXT NOT NULL,
    "team_designation" TEXT NOT NULL,

    CONSTRAINT "players_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "referees" (
    "agent_id" INTEGER NOT NULL,
    "club_initials" TEXT,

    CONSTRAINT "referees_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "coaches" (
    "agent_id" INTEGER NOT NULL,

    CONSTRAINT "coaches_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "managers" (
    "agent_id" INTEGER NOT NULL,

    CONSTRAINT "managers_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "officials" (
    "agent_id" INTEGER NOT NULL,

    CONSTRAINT "officials_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "physiotherapists" (
    "agent_id" INTEGER NOT NULL,

    CONSTRAINT "physiotherapists_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "fitness_coaches" (
    "agent_id" INTEGER NOT NULL,

    CONSTRAINT "fitness_coaches_pkey" PRIMARY KEY ("agent_id")
);

-- CreateTable
CREATE TABLE "clubs" (
    "initials" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "clubs_pkey" PRIMARY KEY ("initials")
);

-- CreateTable
CREATE TABLE "teams" (
    "id" TEXT NOT NULL,
    "designation" TEXT NOT NULL,
    "club_initials" TEXT NOT NULL,

    CONSTRAINT "teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CoachToTeam" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ClubToManager" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ClubToPhysiotherapist" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ClubToFitnessCoach" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "clubs_name_key" ON "clubs"("name");

-- CreateIndex
CREATE UNIQUE INDEX "teams_designation_club_initials_key" ON "teams"("designation", "club_initials");

-- CreateIndex
CREATE UNIQUE INDEX "_CoachToTeam_AB_unique" ON "_CoachToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_CoachToTeam_B_index" ON "_CoachToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ClubToManager_AB_unique" ON "_ClubToManager"("A", "B");

-- CreateIndex
CREATE INDEX "_ClubToManager_B_index" ON "_ClubToManager"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ClubToPhysiotherapist_AB_unique" ON "_ClubToPhysiotherapist"("A", "B");

-- CreateIndex
CREATE INDEX "_ClubToPhysiotherapist_B_index" ON "_ClubToPhysiotherapist"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ClubToFitnessCoach_AB_unique" ON "_ClubToFitnessCoach"("A", "B");

-- CreateIndex
CREATE INDEX "_ClubToFitnessCoach_B_index" ON "_ClubToFitnessCoach"("B");

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_team_designation_club_initials_fkey" FOREIGN KEY ("team_designation", "club_initials") REFERENCES "teams"("designation", "club_initials") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referees" ADD CONSTRAINT "referees_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referees" ADD CONSTRAINT "referees_club_initials_fkey" FOREIGN KEY ("club_initials") REFERENCES "clubs"("initials") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coaches" ADD CONSTRAINT "coaches_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "managers" ADD CONSTRAINT "managers_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "officials" ADD CONSTRAINT "officials_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "physiotherapists" ADD CONSTRAINT "physiotherapists_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fitness_coaches" ADD CONSTRAINT "fitness_coaches_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teams" ADD CONSTRAINT "teams_club_initials_fkey" FOREIGN KEY ("club_initials") REFERENCES "clubs"("initials") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CoachToTeam" ADD CONSTRAINT "_CoachToTeam_A_fkey" FOREIGN KEY ("A") REFERENCES "coaches"("agent_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CoachToTeam" ADD CONSTRAINT "_CoachToTeam_B_fkey" FOREIGN KEY ("B") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToManager" ADD CONSTRAINT "_ClubToManager_A_fkey" FOREIGN KEY ("A") REFERENCES "clubs"("initials") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToManager" ADD CONSTRAINT "_ClubToManager_B_fkey" FOREIGN KEY ("B") REFERENCES "managers"("agent_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToPhysiotherapist" ADD CONSTRAINT "_ClubToPhysiotherapist_A_fkey" FOREIGN KEY ("A") REFERENCES "clubs"("initials") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToPhysiotherapist" ADD CONSTRAINT "_ClubToPhysiotherapist_B_fkey" FOREIGN KEY ("B") REFERENCES "physiotherapists"("agent_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToFitnessCoach" ADD CONSTRAINT "_ClubToFitnessCoach_A_fkey" FOREIGN KEY ("A") REFERENCES "clubs"("initials") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClubToFitnessCoach" ADD CONSTRAINT "_ClubToFitnessCoach_B_fkey" FOREIGN KEY ("B") REFERENCES "fitness_coaches"("agent_id") ON DELETE CASCADE ON UPDATE CASCADE;
