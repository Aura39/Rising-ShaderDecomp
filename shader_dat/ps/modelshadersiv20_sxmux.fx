sampler A_Occ_sampler;
sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;
float4 specularParam;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float3 r5;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.xyz = r0.yyy * light_Color.xyz;
	r0.y = r0.y + -0.5;
	r1.w = max(r0.y, 0);
	r0.yzw = r1.xyz * r0.xxx + i.texcoord2.xyz;
	r2 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r3 = tex2D(A_Occ_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2.zwzw);
	r1.xy = -r3.yy + r3.xz;
	r3.w = max(abs(r1.x), abs(r1.y));
	r1.x = r3.w + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r3.xz = (r1.xx >= 0) ? r3.yy : r3.xz;
	r1.xyz = r1.www + r3.xyz;
	r4.xy = -r2.yy + r2.xz;
	r1.w = max(abs(r4.x), abs(r4.y));
	r1.w = r1.w + -0.015625;
	r3.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r3.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r2.xz = (r1.ww >= 0) ? r2.yy : r2.xz;
	r4.xyz = r2.xyz * i.color.xyz;
	r2.xyz = r2.xyz * i.color.xyz + specularParam.www;
	r5.xyz = r1.xyz * r4.xyz;
	r3.xyz = r3.xyz * r4.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r0.yzw = r0.yzw * r5.xyz;
	r0.yzw = r3.xyz * ambient_rate_rate.xyz + r0.yzw;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r4.xyz = normalize(r3.xyz);
	r1.w = dot(r4.xyz, i.texcoord3.xyz);
	r3.x = -r1.w + 1;
	r3.x = r3.x * -specularParam.z + r1.w;
	r3.y = specularParam.y;
	r3 = tex2D(Spec_Pow_sampler, r3);
	r3.xyz = r3.xyz * light_Color.xyz;
	r3.xyz = r2.www * r3.xyz;
	r3.xyz = r0.xxx * r3.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r0.x = abs(specularParam.x);
	r1.xyz = r0.xxx * r1.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
