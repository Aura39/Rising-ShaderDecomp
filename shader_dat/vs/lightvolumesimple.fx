float4x4 g_WorldViewProj : register(c24);

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldViewProj)[0]);
	r1.y = dot(r0, transpose(g_WorldViewProj)[1]);
	r1.z = dot(r0, transpose(g_WorldViewProj)[2]);
	r1.w = dot(r0, transpose(g_WorldViewProj)[3]);
	o.position = r1;
	o.texcoord = r1;

	return o;
}
