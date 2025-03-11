sampler Color_1_sampler : register(s0);
float4 ambient_rate : register(c40);
float3 fog : register(c49);
float4 fogParam : register(c50);
float4 prefogcolor_enhance : register(c54);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0 = tex2D(Color_1_sampler, i.texcoord);
	r1.w = ambient_rate.w;
	r1 = r0.w * r1.w + -0.01;
	r0 = r0 * ambient_rate;
	r0 = r0 * i.color;
	clip(r1);
	r1.x = -fogParam.x + fogParam.y;
	r1.x = 1 / r1.x;
	r1.y = fogParam.y + i.texcoord1.z;
	r1.x = r1.x * r1.y;
	r2.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	o.xyz = r1.xxx * r0.xyz + fog.xyz;

	return o;
}
