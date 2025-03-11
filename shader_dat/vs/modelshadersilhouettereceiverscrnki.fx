float4x4 g_Proj : register(c4);
float4x4 g_WorldView : register(c20);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r0.x = dot(r1, transpose(g_Proj)[0]);
	r0.y = dot(r1, transpose(g_Proj)[1]);
	r0.z = dot(r1, transpose(g_Proj)[2]);
	r0.w = dot(r1, transpose(g_Proj)[3]);
	o.position = r0;
	o.texcoord = r0;
	o.texcoord1 = i.texcoord.xy;

	return o;
}
