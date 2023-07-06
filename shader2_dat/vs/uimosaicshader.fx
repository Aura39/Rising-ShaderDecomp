float4 g_Color;
float4 g_DivParam;
float2 g_HalfPixel;
float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float r1;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r0, transpose(g_ViewProjMatrix)[3]);
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	r0.x = dot(r0, transpose(g_ViewProjMatrix)[1]);
	o.position.y = r0.x + g_HalfPixel.y;
	o.position.x = r1.x + g_HalfPixel.x;
	o.texcoord1 = g_Color * i.color;
	o.position.z = 0;
	o.texcoord = i.texcoord.xy;
	o.texcoord2 = g_DivParam;

	return o;
}
