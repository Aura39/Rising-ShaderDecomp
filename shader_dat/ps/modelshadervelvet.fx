float4 g_color : register(c185);
float4 g_otherParam : register(c186);
float4 prefogcolor_enhance : register(c184);

struct PS_IN
{
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float r1;
	r0.x = dot(i.texcoord1.xyz, i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r1.x = 3;
	r0.y = r1.x + g_otherParam.x;
	r0 = -r0.x + r0.y;
	r1.x = r0.w * 0.2;
	clip(r0);
	r0.xyz = normalize(-i.texcoord1.xyz);
	r0.x = dot(r0.xyz, i.texcoord3.xyz);
	r0.x = r0.x * 178.5 + 0.5;
	r0.y = frac(r0.x);
	r0.x = -r0.y + r0.x;
	r0.x = r0.x * -0.003921569 + 1;
	r0.x = r0.x * r0.x;
	r0.x = r0.x * r0.x;
	r0.xyz = r0.xxx * prefogcolor_enhance.xyz;
	r0.xyz = r0.xyz * g_color.xyz;
	o.xyz = r1.xxx * r0.xyz;
	o.w = 1;

	return o;
}
