import Link from "next/link";

export default function ComicItem({
  props,
}: {
  props: { image: string; title: string; path: string };
}) {
  if (!props) {
    return <div>존재하지 않는 웹툰</div>;
  }
  return (
    <Link className="block" href={props.path}>
      <div className="w-36 m-3">
        <img className="w-full h-44 rounded-lg mb-3" src={props.image} />
        <div className="overflow-hidden whitespace-nowrap text-ellipsis break-words text-center">
          {props.title}
        </div>
      </div>
    </Link>
  );
}
