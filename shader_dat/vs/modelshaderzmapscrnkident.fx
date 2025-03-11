float g_DentRate : register(c190);
float4x4 g_WorldViewProj : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
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
	r0.x = -0.5 + i.color.y;
	r0.xyz = r0.xxx * i.normal.xyz;
	r0.xyz = r0.xyz * g_DentRate.xxx;
	r0.xyz = r0.xyz * -2 + i.position.xyz;
	r0.w = 1;
	r1.x = dot(r0, transpose(g_WorldViewProj)[0]);
	r1.y = dot(r0, transpose(g_WorldViewProj)[1]);
	r1.z = dot(r0, transpose(g_WorldViewProj)[2]);
	r1.w = dot(r0, transpose(g_WorldViewProj)[3]);
	o.position = r1;
	o.texcoord = r1;
	o.texcoord1 = i.texcoord.xy;

	return o;
}
