"use server";

import { PrismaClient } from "@prisma/client";

export async function userFromToken(token: string) {
  const prisma = new PrismaClient();
  const session = await prisma.userTokens.findFirst({
    where: {
      Token: token,
    },
  });
  if (!session?.UserID) return undefined;
  const user = await prisma.users.findFirst({
    where: {
      UserID: session.UserID,
    },
  });
  prisma.$disconnect();
  return user;
}
