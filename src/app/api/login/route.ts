import { cookies } from "next/headers";
import { PrismaClient } from "@prisma/client";
import { randomUUID } from "crypto";
import { NextResponse } from "next/server";

export async function POST(request: Request) {
  let body: { id: string; pw: string };
  try {
    body = await request.json();
  } catch (e) {
    return NextResponse.json("No user info in body", { status: 403 });
  }

  const prisma = new PrismaClient();
  const users = await prisma.users.findMany({
    where: {
      Username: body.id,
      PasswordHash: body.pw,
    },
  });
  if (users.length != 1)
    return NextResponse.json("No user found", { status: 403 });

  const user = users[0];
  const token = randomUUID();
  const expirationDate = new Date();
  expirationDate.setDate(expirationDate.getDate() + 7);
  await prisma.userTokens.create({
    data: {
      Token: token,
      UserID: user.UserID,
      CreationDate: new Date(),
      Expiration: expirationDate,
    },
  });
  cookies().set("token", token, { httpOnly: true });
  return Response.json({ token: token });
}
