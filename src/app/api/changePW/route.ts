import { logout } from "@/func/logout";
import { userFromToken } from "@/func/userFromToken";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

export async function POST(request: NextRequest) {
  let body: { pw: string };
  try {
    body = await request.json();
  } catch (e) {
    return NextResponse.json("No pw info in body", { status: 400 });
  }

  const token = cookies().get("token")?.value;
  if (!token) return NextResponse.json("Invalid Session", { status: 403 });

  const user = await userFromToken(token);
  if (!user) return NextResponse.json("Invalid Session", { status: 403 });

  const prisma = new PrismaClient();
  await prisma.users.update({
    where: {
      UserID: user.UserID,
    },
    data: {
      PasswordHash: body.pw,
    },
  });
  prisma.$disconnect();

  await logout(token);
  return NextResponse.redirect(new URL("/", request.url));
}
