"use server";
import React from "react";
import ToolBar from "./home/components/ToolBar";
import SectionTitleBar from "./home/components/SectionTitleBar";
import HorizontalComicList from "./home/components/HorizontalComicList";
import VerticalComicList from "./home/components/VerticalComicList";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { userFromToken } from "@/func/userFromToken";

export default async function Page() {
  const TOOLBAR_HEIGHT = 70;

  const prisma = new PrismaClient();
  const webtoons = await prisma.webtoons.findMany();
  const date = new Date();
  const todayWebtoons = await prisma.webtoons.findMany({
    where: {
      PublishDay: date.getDay(),
    },
  });

  let user, token;
  token = cookies().get("token");
  if (token) {
    user = await userFromToken(token.value);
  }

  return (
    <>
      <ToolBar
        title={"웹툰 서비스 데모"}
        height={TOOLBAR_HEIGHT}
        userName={user?.Username ?? undefined}
      />
      <div style={{ paddingTop: TOOLBAR_HEIGHT, background: "white" }}>
        <SectionTitleBar title={"오늘 연재"} description={"설명"} />
        <HorizontalComicList props={{ comicList: todayWebtoons }} />
        <SectionTitleBar title={"전체웹툰"} description={"설명"} />
        <VerticalComicList props={{ comicList: webtoons }} />
      </div>
    </>
  );
}
