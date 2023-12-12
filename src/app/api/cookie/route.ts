import { userFromToken } from "@/func/userFromToken";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  const token = cookies().get("token")?.value;
  if (!token) return NextResponse.json("No token", { status: 403 });

  const user = await userFromToken(token);
  const prisma = new PrismaClient();
  const reader = await prisma.readers.findFirst({
    where: { ReaderID: user?.UserID },
  });

  prisma.$disconnect();
  if (!reader) return NextResponse.json("No reader", { status: 403 });
  return NextResponse.json(reader.ReaderID);
}
