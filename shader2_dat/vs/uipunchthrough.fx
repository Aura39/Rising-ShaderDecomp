float4 g_Threshold : register(c65);
float4x4 g_ViewProjMatrix : register(c54);
float4x4 g_WorldMatrix : register(c58);
float4 g_color : register(c62);
float2 g_halfPixel : register(c64);

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
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 color : COLOR;
	float4 color1 : COLOR1;
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
	o.position.y = r0.x + g_halfPixel.y;
	o.position.x = r1.x + g_halfPixel.x;
	o.position.z = 0;
	o.texcoord = i.texcoord.xy;
	o.texcoord1 = i.texcoord.zw;
	o.texcoord2 = g_Threshold;
	o.color = i.color;
	o.color1 = g_color;

	return o;
}
