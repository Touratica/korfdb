import { PrismaClientKnownRequestError } from "@prisma/client/runtime";
import type { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../lib/prisma";

export default async function handle(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const playerId = req.query.id;

  switch (req.method) {
    case "GET":
      return handleGET(playerId, res);

    case "DELETE":
      return handleDELETE(playerId, res);

    default:
      throw new Error(
        `The HTTP ${req.method} method is not supported at this route.`
      );
  }
}

// GET /api/player/:id
async function handleGET(playerId, res) {
  await prisma.player
    .findUniqueOrThrow({
      select: {
        agentId: true,
        agent: { select: { name: true } },
        clubInitials: true,
        teamDesignation: true,
      },
      where: { agentId: Number(playerId) },
    })
    .then((player) => res.json(player))
    .catch((error) => {
      if (
        error instanceof PrismaClientKnownRequestError &&
        error.code === "P2025"
      ) {
        return res.status(404).json({ message: "Player not found" });
      }
    });
}

// DELETE /api/player/:id
async function handleDELETE(postId, res) {
  await prisma.player
    .delete({
      where: { agentId: Number(postId) },
    })
    .then((player) => res.json(player))
    .catch((error) => {
      if (
        error instanceof PrismaClientKnownRequestError &&
        error.code === "P2025"
      ) {
        return res.status(404).json({ message: "Player not found" });
      }
    });
}
