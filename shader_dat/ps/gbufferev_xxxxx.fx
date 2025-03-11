float4 fogType : register(c175);
sampler g_Color_1_sampler : register(s0);
float4 g_texUseParam : register(c184);
float4 lightType : register(c174);

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
};

PS_OUT main(float2 texcoord1 : TEXCOORD1)
{
	PS_OUT o;

	float4 r0;
	r0 = tex2D(g_Color_1_sampler, texcoord1);
	r0 = r0.w + -g_texUseParam.x;
	clip(r0);
	o.color = lightType;
	o.color1 = fogType;

	return o;
}
