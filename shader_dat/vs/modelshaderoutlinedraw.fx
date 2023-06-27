struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	o.position = i.position * float4(2.01, 2.01, 1, 1) + float4(1.005, 1.005, 0, 0);
	o.texcoord = i.texcoord.xy;

	return o;
}
